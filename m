Return-Path: <b_kisku@yahoo.co.in>
Received: from web8506.mail.in.yahoo.com (web8506.mail.in.yahoo.com
	[202.43.219.168]) by ozlabs.org (Postfix) with SMTP id C0D98DDF12
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  3 Jul 2007 21:30:07 +1000 (EST)
Date: Tue, 3 Jul 2007 12:23:25 +0100 (BST)
From: Barisa kisku <b_kisku@yahoo.co.in>
Subject: NFS mounting problem in mpc860 based board
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <566752.34558.qm@web8506.mail.in.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi,

I have ported u-boot 1.1.6 in a custom board based on
mpc860.using "tftpboot" command Linux kernel uImage is
downloaded.And it was run with "bootm" command and
controls are transfered to linux properly.

While kernel is mounting root file system through nfs
it is not able to send the message properly.By
observing through "Ethereal" at server machine, no ARP
message is reaching.

Print coming in console of embedded system is:
portmap: "Unable to get port number for  nfsd of
server"

But i am able to mount the file system in the given
server from other machine in the LAN.

Again by looking at the status of the BDs it seems
that the ethernet driver is sending message properly
to the LAN.

If anybody has come across this type of problem,
please help me in debugging.

Thanks in advance.

Regards,
Barisa Kisku







		
__________________________________________________________
Yahoo! India Answers: Share what you know. Learn something new
http://in.answers.yahoo.com/
