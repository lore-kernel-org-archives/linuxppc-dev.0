Date: Thu, 13 Jul 2000 11:24:07 -0700
Subject: Re: Xfree 4.0.1 dual head attempt
From: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
To: Nelson Abramson <pogtal@erols.com>
CC: Linux PPC Developer List <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B5935757.2DC%wtholliday@ucdavis.edu>
In-Reply-To: <396DCBCB.A4A574C8@erols.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> This may be a stupid question, but why have you commented out your input
> devices?
>
> --Nelson Abramson
>

I'm using implicit input devices - that is basically left over from when I
was understanding XF 4 config.
See http://www.xfree86.org/4.0.1/DESIGN2.html. I doubt the segfault has
anything to do with the implicit devices because they work just fine with a
single monitor. Nonetheless, I'm going to revert to explicit devices to
simplify things.

-Taylor


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
