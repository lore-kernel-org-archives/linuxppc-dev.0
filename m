Subject: RE: Question about modules
From: Ibon Gotxi Garcia <igotxi@jazzfree.com>
To: Jean-Denis Boyer <jdboyer@mediatrix.com>
Cc: Linux PPC embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <2702075D4DE2B043BF5EB82E9CFAD45B093BC7@mail1.mediatrix.com>
References: <2702075D4DE2B043BF5EB82E9CFAD45B093BC7@mail1.mediatrix.com>
Content-Type: text/plain; charset=ISO-8859-1
Message-Id: <1046458106.360.15.camel@muse>
Mime-Version: 1.0
Date: 28 Feb 2003 18:48:26 +0000
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, 2003-02-28 at 18:27, Jean-Denis Boyer wrote:
> > Everything works, till I try to insmod it: I get m8xx_cpm_alloc and
> > m8xx_cpm_hostalloc as unresolved symbols.
>
> In commproc.c, add the following line:
>   EXPORT_SYMBOL(m8xx_cpm_hostalloc);
>


ok, i have already thought about that, but it means that my driver won't
work with "standard" kernels, isn't it?

people should change their kernel code to load my drivers, and that
isn't cool :(

thanks for your answer

Cheers
ibon.


>
> Regards,
>
> --------------------------------------------
>  Jean-Denis Boyer, B.Eng., Technical Leader
>  Mediatrix Telecom Inc.
>  4229 Garlock Street
>  Sherbrooke (Québec)
>  J1L 2C8  CANADA
>  (819)829-8749 x241
> --------------------------------------------
>
--
Ibon Gotxi Garcia <igotxi@jazzfree.com>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
