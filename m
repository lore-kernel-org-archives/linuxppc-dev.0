Message-Id: <4.2.2.20000203124644.00d6e9f0@mail.munich.netsurf.de>
Date: Thu, 03 Feb 2000 12:50:43 +0100
To: Patrik Jonsson <patrik@ucolick.org>
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: lidstdc++ string problems
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.GSO.4.03.10002030203260.27105-100000@isis.ucolick.org
 >
References: <38993D7F.B0964A77@dalim.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 11:10 03.02.00 , Patrik Jonsson wrote:

>Hi everyone,
>
>I wonder if there is a known problem with the c++ string class? (I just
>upgraded to gcc 2.95.2, but it didn't help.) What happens is that I read
>into a string from a char* using a strstream as " strstream >> string".
>This works on other machines, but on linuxppc the resulting string
>contains junk at the end that is in another string object defined earlier.
>It's like it doesn't properly define what the length is. If I look at it
>in gdb, the "dat" field contains the right char*, but when reading it more
>stuff appears at the end. It's HIGHLY annoying, it's plain impossible to
>make anything work! Is this known / is there a fix or something? It seems
>bad if we can't trust the standard library... :(

Can you send me a small testcase that abort()'s if the bug is hit and does
exit(0) otherwise? Which gcc-2.95.2 RPM did you use? 1g? Which compiler
options? Does -W -Wall warn about anything?

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
