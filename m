Message-ID: <37D0F88E70D96C428C19EEB865701A38E834F3@buda902a.siemens.hu>
From: =?ISO-8859-1?Q?M=E9sz=E1ros_Lajos?= <ludwigm@siemens.hu>
To: linuxppc-embedded@lists.linuxppc.org
Subject: 8260 timer
Date: Thu, 6 Jun 2002 13:10:55 +0200 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi All!

On our MPC8260ADS board the 2.4.18 kernel starts fine from PPCBoot, but
after
"Warning: real time clock seems stuck!"
   message, (which seems true) stops on
"Calibrating delay loop... "
   message. (which proves the previous assumption)

Where to find the initial settings of the 8260 timer?
In the PPCBoot or in the kernel?

Best Regards
	Ludwig

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
