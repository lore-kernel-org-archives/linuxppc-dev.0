Return-Path: <krypton@ulrich-teichert.org>
Received: from arbas.nms.ulrich-teichert.org (i3ED64D7B.versanet.de
	[62.214.77.123]) by ozlabs.org (Postfix) with ESMTP id 769D22BF07
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Jan 2005 19:10:55 +1100 (EST)
Message-Id: <200501050807.j0587L5J026680@arbas.nms.ulrich-teichert.org>
To: mikemartin@linux.ca
Date: Wed, 5 Jan 2005 09:07:20 +0100 (MET)
In-Reply-To: <855e88d005010420367a92617a@mail.gmail.com> from "Mike Martin" at
	Jan 04, 2005 11:36:49 PM
From: Ulrich Teichert <krypton@ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Ulrich Teichert <krypton@ulrich-teichert.org>, linuxppc-dev@ozlabs.org,
	debian-powerpc@lists.debian.org, Philippe Guyot <pguyot@cvf.fr>
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

[del]
>Done - no difference. Same message. Written multiple images, multiple
>times on multiple machine. Each one with the same result. At least I'm
>not completely alone, I found this:
>http://wikihip.cern.ch/twiki/bin/view/RS6000/KernelTestsOn43P240 exact
>same error.

Perhaps there are two different board revisions of -140's out? I'll check
what's written on the system board when I'm home again today.

>> > I am begining to believe that there is some sort of hardware problem with your
>> > box or it is an upgraded version which was a -140 in it's previous life, but my
>> > -140 is rock solid with Leigh's 2.4.19 kernel - once it's up, that is.
>> > I will leave it running tonight to see what happens,
[del]

Still running fine:

wehrle:~> uname -a
Linux wehrle 2.4.19 #3 Sun Aug 4 08:28:30 BST 2002 ppc unknown
wehrle:~> uptime
 08:58:25 up 13:08,  1 user,  load average: 0.00, 0.00, 0.00

I did a kernel compile with a parallel scp transfer as well to put the box
under a bit of load before, no issues.

HTH,
Uli
-- 
Dipl. Inf. Ulrich Teichert|e-mail: Ulrich.Teichert@gmx.de
Stormweg 24               |listening to: Suicide Drive (The Deep Eynde)
24539 Neumuenster, Germany|Public Pervert (Interpol) Clé De Contact (Metal Urbain)
