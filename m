Message-ID: <D73A25AA6E54D511AD74009027B1110F3C0A02@ORION>
From: Steven Blakeslee <BlakesleeS@embeddedplanet.com>
To: "'Qsyang'" <yangqs@163.com>, linuxppc-embedded@lists.linuxppc.org
Subject: RE: Can i use BDI2000 to debug "U-Boot" in Flash memory ?
Date: Tue, 26 Aug 2003 09:02:20 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


If you are debugging the code from FLASH make sure you use hardware break
points, software break points will not work.

-----Original Message-----
From: Qsyang [mailto:yangqs@163.com]
Sent: Monday, August 25, 2003 9:21 PM
To: linuxppc-embedded@lists.linuxppc.org
Subject: Can i use BDI2000 to debug "U-Boot" in Flash memory ?



 Hi:
 i am new to this, i am porting U-Boot to my MPC852 board. First of
 all i programed the monitor code to Flash memory through BDI2000, i
 just want getting into a normal "C" debug enviroment,is that right? or
 should i place it into Sdram?(some guy told me,but it has problem,maybe
 my fault) any help would be appreciated !

　　　　　　　　Qsyang
　　　　　　　　yangqs@163.com
　　　　　　　　　　2003-08-26


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
