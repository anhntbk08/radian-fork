define [
  'config'
  'angular'
  'controller/app-controller'
  'factory/page-loader-factory'
  'factory/page-title-factory'
], (cfg, A) ->
  describe 'App controller', () ->
    $scope = null
    createController = null
    pageLoaderFactory = null
    pageTitleFactory = null

    beforeEach module cfg.ngApp

    beforeEach inject ($injector) ->
      $controller = $injector.get '$controller'
      $rootScope = $injector.get '$rootScope'
      pageLoaderFactory = $injector.get 'pageLoaderFactory'
      pageTitleFactory = $injector.get 'pageTitleFactory'

      $scope = $rootScope.$new()

      createController = () ->
        $controller 'AppController',
          $scope: $scope
          pageTitleFactory: pageTitleFactory

    it 'should add the header and footer partials', () ->
      controller = createController()

      expect($scope.headerPartial).toBeDefined()
      expect($scope.footerPartial).toBeDefined()

    it 'should change the title when an event is fired from pageTitleFactory', () ->
      controller = createController()
      title = 'foo'

      pageTitleFactory.setTitle title

      expect($scope.pageTitle).toContain title

    it 'should hide the loader when an event is fired from pageLoaderFactory', () ->
      controller = createController()

      $scope.handleViewLoaded()

      expect($scope.hideLoader).toBe true