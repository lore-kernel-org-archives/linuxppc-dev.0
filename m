Date: Wed, 24 Apr 2002 21:25:01 +0200 (CEST)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: diff, patch, and symbolic links
To: Eric.Oosterhof@radisys.com
Cc: PRuhland@microwavedata.com, linuxppc-dev@lists.linuxppc.org
In-Reply-To: <OF97E48CDE.74B2B7E9-ON88256BA5.0065B1DB@radisys.com>
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Message-Id: <E170SO4-000076-00@piglet.grunz.lu>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  24 Apr, this message from Eric.Oosterhof@radisys.com echoed through cyberspace:
>>I always do a 'make mrproper' and then an 'rm -f .config*' ( from the root
>>of the linux tree of course ) before generating any patch files.  Just be
>>sure to save your '.config' somewhere before you remove it.
>>
>>This way all generated files including the 'include/asm' symlink are
>>removed.
>>
> I did a 'make mrproper' prior, and I still have the symlink.  I also
> deleted it by hand, but that didn't help.  In fact, I even have that
> symlink in the original tree.  Is that the root of all evil?  Lastly, when
> I deleted the .config, and then do the diff and patch, patch complains that
> it wants to erase the .config in the ORIGINAL tree, which is totally wrong!
> I absolutely can't have the patch trying to affect the original tree - why
> does that even begin to occur?

Because your 'original' tree has the symlink also. Do a 'make mrproper'
in _both_ trees. That has always worked for me....

At any rate, there's no reason to have build files (symlinks, .config's
et al) in your 'original' tree.

Cheers

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
