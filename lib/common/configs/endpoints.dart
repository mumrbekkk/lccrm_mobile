import 'main_config.dart';

const loginEndpoint = "$apiV1BaseUrl/auth/login/";

const profileDetailsEndpoint = "$apiV1BaseUrl/auth/profile/details/";

const getAllNotificationsEndpoint = "$apiV1BaseUrl/auth/notifications/all";
const getUnreadNotificationsCountEndpoint = "$apiV1BaseUrl/auth/notifications/unread-count";
const markAllNotificationsAsReadEndpoint = "$apiV1BaseUrl/auth/notifications/mark-all-as-read/";


// Students
const getStudentAttendanceStatisticsEndpoint = "$apiV1BaseUrl/students/dashboard/attendance/statistics/";
const getStudentCoinHistoryEndpoint = "$apiV1BaseUrl/students/common/coins/";
const getStudentCoinCountEndpoint = "$apiV1BaseUrl/students/common/coins/count/";
// const getStudentCourseDetailEndpoint = "$apiV1BaseUrl/students/group-details/$groupId/"; TODO make this work
const getStudentCoursesEndpoint = "$apiV1BaseUrl/students/student-groups/";
const getStudentCourseDetailsEndpoint = "$apiV1BaseUrl/students/group-details/";
const getStudentRatingsEndpoint = "$apiV1BaseUrl/students/ratings/overall-mark-rating/";
const getStudentGroupRatingsEndpoint = "$apiV1BaseUrl/students/ratings/groups-mark-rating/";
const getStudentScheduleEndpoint = "$apiV1BaseUrl/students/timetable/weekly/";