Date: Mon, 3 Dec 2001 12:45:59 +0100
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_ALL_PPC
Message-ID: <20011203124559.A3441@suse.de>
References: <3C0561FE.80489F5E@vnet.ibm.com> <20011128221928.8366@smtp.wanadoo.fr> <15365.29851.123004.897729@gargle.gargle.HOWL> <20011129011941.A10393@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011129011941.A10393@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Nov 29, Olaf Hering wrote:

>
> On Thu, Nov 29, Paul Mackeras wrote:
>
> >
> > Benjamin Herrenschmidt writes:
> >
> > > It's a difficult choice ;)
> > >
> > > What about CONFIG_COMMON_PPC ? Still a bit misleading, but probably
> > > better than CONFIG_ALL_PPC...
> >
> > You know, what I am really tempted to do is to split out prep again
> > and have a CONFIG_PPC_OPENFIRMWARE to indicate pmac and chrp and
> > anything else that has a working OF.  But Olaf would kill me... :)
>
> Hmm, why? :)

Ok, got that.
Is it worth the trouble?

banana:/usr/src/linux # l arch/ppc/kernel/*prep*o drivers/video/*vga*o
-rw-r--r--    1 root     root         3172 Dec  3 11:32 arch/ppc/kernel/prep_nvram.o
-rw-r--r--    1 root     root        17108 Dec  3 11:32 arch/ppc/kernel/prep_pci.o
-rw-r--r--    1 root     root        16412 Dec  3 11:32 arch/ppc/kernel/prep_setup.o
-rw-r--r--    1 root     root         7188 Dec  3 11:32 arch/ppc/kernel/prep_time.o
-rw-r--r--    1 root     root        29084 Dec  3 11:17 drivers/video/vgacon.o

70kb uncompressed code.


Gruss Olaf

--
 $ man clone

BUGS
       Main feature not yet implemented...

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
