From: Eric.Oosterhof@radisys.com
Subject: RE: diff, patch, and symbolic links
To: "Ruhland, Paul" <PRuhland@microwavedata.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-ID: <OF97E48CDE.74B2B7E9-ON88256BA5.0065B1DB@radisys.com>
Date: Wed, 24 Apr 2002 11:34:01 -0700
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Paul Ruhland suggests:
>Eric,
>
>I always do a 'make mrproper' and then an 'rm -f .config*' ( from the root
>of the linux tree of course ) before generating any patch files.  Just be
>sure to save your '.config' somewhere before you remove it.
>
>This way all generated files including the 'include/asm' symlink are
>removed.
>
>--
>Paul Ruhland
I did a 'make mrproper' prior, and I still have the symlink.  I also
deleted it by hand, but that didn't help.  In fact, I even have that
symlink in the original tree.  Is that the root of all evil?  Lastly, when
I deleted the .config, and then do the diff and patch, patch complains that
it wants to erase the .config in the ORIGINAL tree, which is totally wrong!
I absolutely can't have the patch trying to affect the original tree - why
does that even begin to occur?


Eric Oosterhof


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
