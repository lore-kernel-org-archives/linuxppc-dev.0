From: "T Michael Turney" <tmike@recipes4linux.com>
To: "Jack Liu" <Jack_liu@usish.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: RE: linux shell
Date: Wed, 23 Jun 2004 09:02:24 -0700
Message-ID: <GEEKLLHMFHLAJOBEEELHOEBMCKAA.tmike@recipes4linux.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-reply-to: <200406230935.i5N9Z5V9030272@ms.usish.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


. file
is a built-in shell command.  It executes the commands
in file in the current shell, no sub-shell is spawned.
Since no sub-shell is spawned, variable settings stay in effect.
file is found along $PATH and does not have to be executable.
Cheers,
T.mike

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Jack Liu
Sent: Wednesday, June 23, 2004 2:35 AM
To: linuxppc-embedded@lists.linuxppc.org
Subject: linux shell



hi,all

 I am wondering about the usage of ". ifcfg-eth0" since ifcfg-eth0 is
not an execuatable. Can anyone tell me?

Best regards
Jack Liu


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
