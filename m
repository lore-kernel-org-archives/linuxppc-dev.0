Message-ID: <40E44F7E.4090108@246tNt.com>
Date: Thu, 01 Jul 2004 19:53:02 +0200
From: Sylvain Munaut <tnt@246tnt.com>
MIME-Version: 1.0
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: getting support for command-line flash partitioning
References: <Pine.LNX.4.60.0407011037010.15415@localhost.localdomain> <1088695697.14216.3060.camel@hades.cambridge.redhat.com> <Pine.LNX.4.60.0407011244070.16076@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.60.0407011244070.16076@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Robert P. J. Day wrote:

| and neither the latest "bk pull" of the 2.5/2.6 kernel from
| bkbits.net, or the standard 2.6 kernel on my fedora core system has
| *any* support for that feature in the map files (even though the
| kernel has the internal support).
|
Are you sure about that ?

tnt@246tNt-laptop maps $ grep cmdline *
ceiva.c:static const char *probes[] = { "cmdlinepart", "RedBoot", NULL };
dc21285.c:static const char *probes[] = { "RedBoot", "cmdlinepart",NULL };
edb7312.c:static const char *probes[] = { "RedBoot", "cmdlinepart",NULL };
h720x-flash.c:static const char *probes[] = { "cmdlinepart", NULL };
impa7.c:static const char *probes[] = { "cmdlinepart", NULL };
integrator-flash.c:static const char *probes[] = {
"cmdlinepart","RedBoot", "afs", NULL };
iq80310.c:static const char *probes[] = { "RedBoot", "cmdlinepart",NULL };
ixp4xx.c:static const char *probes[] = { "RedBoot", "cmdlinepart", NULL };
lubbock-flash.c:static const char *probes[] = { "RedBoot","cmdlinepart",
NULL };
physmap.c:const char *part_probes[] = {"cmdlinepart", "RedBoot", NULL};
sa1100-flash.c:const char *part_probes[] = { "cmdlinepart",
"RedBoot",NULL };
solutionengine.c:static const char *probes[] = {
"RedBoot","cmdlinepart", NULL };
wr_sbc82xx_flash.c:static const char *part_probes[] __initdata
={"cmdlinepart", "RedBoot", NULL};


Sylvain Munaut


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
