Message-Id: <v04003a00b4b28de5c863@[216.81.20.207]>
In-Reply-To: 
 <Pine.SOL.3.96.1000124171319.3766A-100000@fitch.math.uwaterloo.ca>
References: <v04003a01b4b27272e182@[216.81.20.207]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Mon, 24 Jan 2000 17:32:47 -0600
To: Robert Neugebauer <rneugeba@undergrad.math.uwaterloo.ca>,
        linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <eek@escape.ca>
Subject: Re: altivec instructions
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 4:16 PM -0600 1/24/00, Robert Neugebauer wrote:
>Wouldn't the 2.2 kernel patches for altivec instructions handle that. I
>don't know if they were supported, but they worked on my G4 and haven't
>caused any instability. I had found them somewhere on devel.linuxppc.org.
>
>I can send them too you if you need.
>
>Bob
[...]

*search, search* Ah, so there is a patch. I assume this is the one you're
referring to?
<http://devel.linuxppc.org/ftp/users/ajoshi/altivec-2.2.patch>

It might just be my imagination, but for some reason it doesn't look like
that patch actually touches any altivec registers other than the VRSAVE...

For a single altivec task on a UP system it might work, though.


While I'm on the subject, does GCC even have altivec support yet? It seems
I always miss all the important announcements... :)


Cheers - Tony :)


--
Tony Mantler         Renaissance Nerd Extraordinaire         eek@escape.ca
Winnipeg, Manitoba, Canada                       http://www.escape.ca/~eek


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
