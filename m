Date: Thu, 1 Jul 2004 14:17:46 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Sylvain Munaut <tnt@246tnt.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: getting support for command-line flash partitioning
In-Reply-To: <40E44F7E.4090108@246tNt.com>
Message-ID: <Pine.LNX.4.60.0407011405540.16567@localhost.localdomain>
References: <Pine.LNX.4.60.0407011037010.15415@localhost.localdomain>
 <1088695697.14216.3060.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.60.0407011244070.16076@localhost.localdomain> <40E44F7E.4090108@246tNt.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, 1 Jul 2004, Sylvain Munaut wrote:

> Robert P. J. Day wrote:
>
> | and neither the latest "bk pull" of the 2.5/2.6 kernel from
> | bkbits.net, or the standard 2.6 kernel on my fedora core system has
> | *any* support for that feature in the map files (even though the
> | kernel has the internal support).
> |
> Are you sure about that ?
>
> tnt@246tNt-laptop maps $ grep cmdline *
> ceiva.c:static const char *probes[] = { "cmdlinepart", "RedBoot", NULL };
> dc21285.c:static const char *probes[] = { "RedBoot", "cmdlinepart",NULL };
> edb7312.c:static const char *probes[] = { "RedBoot", "cmdlinepart",NULL };
> h720x-flash.c:static const char *probes[] = { "cmdlinepart", NULL };
> impa7.c:static const char *probes[] = { "cmdlinepart", NULL };
> integrator-flash.c:static const char *probes[] = { "cmdlinepart","RedBoot",
> "afs", NULL };
> iq80310.c:static const char *probes[] = { "RedBoot", "cmdlinepart",NULL };
> ixp4xx.c:static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };
> lubbock-flash.c:static const char *probes[] = { "RedBoot","cmdlinepart", NULL
> };
> physmap.c:const char *part_probes[] = {"cmdlinepart", "RedBoot", NULL};
> sa1100-flash.c:const char *part_probes[] = { "cmdlinepart", "RedBoot",NULL };
> solutionengine.c:static const char *probes[] = { "RedBoot","cmdlinepart",
> NULL };
> wr_sbc82xx_flash.c:static const char *part_probes[] __initdata
> ={"cmdlinepart", "RedBoot", NULL};

   oops, i was working off the structure of the older kernel version
where the individual files explicitly checked the value of the config
variable CONFIG_MTD_CMDLINE_PARTS to decide what to do, and that's the
string i was grep'ing for.  this clearly changed in the newer files.
mea culpa.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
