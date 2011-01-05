Return-Path: <rbeims@gmail.com>
Received: from mail-fx0-f66.google.com (mail-fx0-f66.google.com
	[209.85.161.66]) by ozlabs.org (Postfix) with ESMTP id 77B31B710D
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2011 05:09:09 +1100 (EST)
Received: by fxm14 with SMTP id 14so4646238fxm.9
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Jan 2011 10:09:06 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 5 Jan 2011 16:09:06 -0200
Message-ID: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>
Subject: mpc880 linux-2.6.32 slow running processes
From: Rafael Beims <rbeims@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=90e6ba211f29edebae04991d47fd
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--90e6ba211f29edebae04991d47fd
Content-Type: text/plain; charset=ISO-8859-1

Hello all,
I'm working with an MPC880 board that is supposed to run linux-2.6.32. After
some work, I could get the kernel up and running, mounting a rootfs via
NFS.
The problem that I'm facing now is that when I try to run any process (may
be an ls, cat, or whatever), the response of the process is *very* slow
(something like 10 to 20 seconds for a ls).
Monitoring the network packets, I can see that the nfs protocol is exchanged
just fine, but at some time it simply stops, starting again with a request
from the board several seconds later.
I'm thinking that the processor is running (something, I don't know what)
for all this time before I can see requests coming from the board again. I
pinged the board from the PC and during all this I can see the packets being
answered.

My question to all is, did anyone see something like this already? Besides
that, what is the status of the linux kernel support for the 8xx platform?
Is it being actively tested / used today? I ask this because it seems that
all the information on the internet very aged (forum discussions from 2005
and below mostly).

Is there something that I can do to try to narrow the cause of the problem?

Anyway, any help would be truly appreciated. Please excuse me if this is not
the right place to ask this too.

Thanks and best regards,
Rafael Beims
rbeims@gmail.com
(41) 8873-7565
"What I hear, I forget. What I see, I remember. And what I do, I
understand."
- Chinese Proverb

--90e6ba211f29edebae04991d47fd
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello all,<div>I&#39;m working with an MPC880 board that is supposed to run=
 linux-2.6.32. After some work, I could get the kernel up and running, moun=
ting a rootfs via NFS.=A0</div><div>The problem that I&#39;m facing now is =
that when I try to run any process (may be an ls, cat, or whatever), the re=
sponse of the process is *very* slow (something like 10 to 20 seconds for a=
 ls).=A0</div>
<div>Monitoring the network packets, I can see that the nfs protocol is exc=
hanged just fine, but at some time it simply stops, starting again with a r=
equest from the board several seconds later.</div><div>I&#39;m thinking tha=
t the processor is running (something, I don&#39;t know what) for all this =
time before I can see requests coming from the board again. I pinged the bo=
ard from the PC and during all this I can see the packets being answered.</=
div>
<div><br></div><div>My question to all is, did anyone see something like th=
is already? Besides that, what is the status of the linux kernel support fo=
r the 8xx platform? Is it being actively tested / used today? I ask this be=
cause it seems that all the information on the internet very aged (forum di=
scussions from 2005 and below mostly).</div>
<div><br></div><div>Is there something that I can do to try to narrow the c=
ause of the problem?</div><div><br></div><div>Anyway, any help would be tru=
ly appreciated. Please excuse me if this is not the right place to ask this=
 too.</div>
<div><br></div><div>Thanks and best regards,<br clear=3D"all">Rafael Beims<=
br><a href=3D"mailto:rbeims@gmail.com">rbeims@gmail.com</a><br>(41) 8873-75=
65<br>&quot;What I hear, I forget. What I see, I remember. And what I do, I=
 understand.&quot;<br>
- Chinese Proverb<br>
</div>

--90e6ba211f29edebae04991d47fd--
