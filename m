Date: Tue, 23 Nov 1999 16:22:58 +0100
Subject: PoerPC 750 (I-) Address Translation Problem
From: Roberto Brega <brega@ifr.mavt.ethz.ch>
To: LinuxPPC-Dev List <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B4606FE2.3256%brega@ifr.mavt.ethz.ch>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi linux-devs,

I (Ph.D. student, non-profit organisation) am writing an experimental
real-time operating system running on PowerPC processors. It already runs on
PowerPC 603x/604x. While porting to the PowerPC 750 (let's say supporting,
not porting) I encountered the following, critical error.

My OS traps right after bootstrapping, as soon as I enable instruction
address translation, with a very clumsy error (the srr1 register shows an
I-fetch from a direct-store segment - which I do not use; or an I-fetch from
guarded space - same here; or an I-fetch from a "no-exec" segment - I do not
set No-Exec in segment registers.

The really weird thing is that the same MMU code (the initialisation of
other parts differ, but the MMU part does not) runs without errors on
603/603e/604/604e processors.

So, I wondered, did you had some porting issues having to do with the
address translation on PowerPC750? Do you have some ideas on what is going
on? Any known errata for this part?

Best regards, thanks for your time,
--Roberto

--------------------------------------------------------------------
 Roberto Brega
    
 Institute of Robotics, CLA H13
 Swiss Federal Institute of Technology
 8092 Zurich, Switzerland
    
 Tel: 01 632 46 56     Fax: 01 632 10 78
 Mobile: 079 636 48 03
 email: brega@ifr.mavt.ethz.ch  (pgp on demand)
 web: www.ifr.mavt.ethz.ch
--------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
