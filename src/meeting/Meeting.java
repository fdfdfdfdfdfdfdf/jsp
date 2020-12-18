package meeting;

public class Meeting {
	private String meetingId;
	private String meetingPassword;
	private String meetingLink;
	private String maxMember;
	private String fileLink;
	
	public String getMeetingId() {
		return meetingId;
	}
	public void setMeetingId(String meetingId) {
		this.meetingId = meetingId;
	}
	public String getMeetingPassword() { return meetingPassword; }
	public void setMeetingPassword(String meetingPassword) {
		this.meetingPassword = meetingPassword;
	}
	public String getMeetingLink() {
		return meetingLink;
	}
	public void setMeetingLink(String meetingLink) {
		this.meetingLink = meetingLink;
	}
	public String getMaxMember() {
		return maxMember;
	}
	public void setMaxMember(String maxMember) {
		this.maxMember = maxMember;
	}
	public String getFileLink() {
		return fileLink;
	}
	public void setFileLink(String fileLink) {
		this.fileLink = fileLink;
	}
}
