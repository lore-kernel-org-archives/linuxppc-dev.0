Message-ID: <81A66F72DCACD511B0600002A551BFCB4E9D60@kuumex05.barco.com>
From: =?iso-8859-1?Q?=22Callebaut=2C_Beno=EEt=22?= <benoit.callebaut@barco.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Time
Date: Fri, 7 Mar 2003 11:17:58 +0100 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In user mode, you can use top. Otherwise in the program, get_time_of_day or
in kernel get_jiffies must work

-----Original Message-----
From: Aman [mailto:aman@mistralsoftware.com]
Sent: Friday, March 07, 2003 11:05 AM
To: linuxppc embedded
Subject: Time



Hi

Can anybody suggest the best way to calculate the time taken by an
application, running on PPC 440.

Thanking you in advance
regards
Aman


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
