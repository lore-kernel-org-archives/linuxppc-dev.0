Message-Id: <200011071947.UAA00693@piglet.grunz.lu>
Date: Tue, 7 Nov 2000 20:47:51 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: controlfb and X
To: flar@pants.nu
cc: bob@kunk.jriver.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20001107070546.08EF32B54A@marcus.pants.nu>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   6 Nov, this message from Brad Boyer echoed through cyberspace:
> Michel Lanners wrote:
>> On   5 Nov, this message from Robert E Brose II echoed through cyberspace:
>> > The problem is that the controlfb driver doesn't recognize more than
>> > 2 megs of vram. This particular Mac 7500 has 4 megs installed which
>> > works perfectly in MacOS.
>>
>> Strange. It should detect 4 meg in 2.2 kernels; but maybe not 2.4
>> kernels.
>
> There's been a long standing issue on detecting the full 4M on controlfb
> that regularly pops up.

Yup. AFAICT, there are two versions of the detect code that have been
alternating between 2.1 kernel versions in the past, then the 2.2
kernels stabilized on the 7x00-friendly version, but the 2.4 kernels
went for the 8x00-savvy version.

> I happen to have a 7600 with the video upgraded to
> 4M, so I've been interested in this as well. I've seen several patches
> float over the list, and I don't think any of them actually worked for
> everyone.

No. Either 7x00-style machines worked, or 8x00.

> I believe the conclusion was that control just didn't act the
> same on every machine. I suspect that if you look back through the list
> archives, you'll find lots of discussion on this topic.

I know; I've participated in most of those discussions ;-)

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
