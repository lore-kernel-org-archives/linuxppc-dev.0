Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Message-Id: <v04204e08b35d9989574a@[206.163.71.146]>
In-Reply-To: <v04003a00b35d22de2b5c@[38.27.133.82]>
References: <v04003a00b35d22de2b5c@[38.27.133.82]>
Date: Tue, 11 May 1999 01:36:38 -0700
To: linuxppc-dev@lists.linuxppc.org
From: Joel Klecker <jk@espy.org>
Subject: Re: imac of booting
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 19:59 -0400 1999-05-10, Ben Martz wrote:
>Stupid question maybe but I can't find a definitive answer. Can I boot
>linuxppc from OF on my iMac? Does the elf loader in OF work?

The ELF loader in OF does work (part of the Mac OS boot process uses 
it in fact), however it does not like Linux kernel ELF images.

Until someone figures out the problem and fixes it, the answer is no.
-- 
Joel Klecker (aka Espy)                    Debian GNU/Linux Developer
<URL:mailto:jk@espy.org>                 <URL:mailto:espy@debian.org>
<URL:http://web.espy.org/>               <URL:http://www.debian.org/>

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
