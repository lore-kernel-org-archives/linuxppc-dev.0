Date: Fri, 7 Sep 2001 01:44:26 -0700 (PDT)
From: James F Dougherty <jfd@GigabitNetworks.COM>
Message-Id: <200109070844.BAA14089@krakatoa.gigabitnetworks.com>
To: jfd@GigabitNetworks.COM, linuxppc-embedded@lists.linuxppc.org,
	fray@mvista.com
Subject: Re: SysVInit (RC Scripts) on HHL 2.0 (Add'n info)
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> Mark Hatle wrote:
> >
> > James F Dougherty wrote:
> >
> > > I am using HHL 2.0 (2.4.2) on MPC8240 and I downloaded
> > > the root filesystem RPM's from
> > >
> > > ftp://ftp.mvista.com/pub/Journeyman/cd2/ppc_82xx/apps/*.rpm
> > >
> > > Is there some bug in HHL 2.0 on ppc_82xx I don't know about?
> >
> > Assuming you used the installer, only the init scripts required to boot
> > a minimal system (and be able to telnet in and use nfs root) are
> > enabled.  Anything beyond that you, the developer/user will need to
> > enable.  If you did not use the installer, you probably got a bunch of
> > messages during installation such as "Unable to enable initd service:
> > checkfs.sh".  These messages mean that the initdconfig program was not
> > able to be run for some reason or another, thus you probably don't have
> > ANY initscripts installed.
> >
> > The initscripts are further discussed in the "Initscript Overview"
> > section of Chapter 7.
>
> FYI, if you did not use the installer, and want to try to "rescue" your
> installation, the following initscripts are enabled by default in the
> installer.  (If I list an initscript you don't have ignore it, it isn't
> part of Journeyman then.)
>
> bootmisc.sh    	S:on
> checkfs.sh     	S:on
> checkroot.sh   	S:on
> devpts.sh      	S:on
> mountall.sh    	S:on
> mountnfs.sh    	S:on
> umountfs       		0:on
6:on
> umountnfs.sh   		0:on
6:on
> ifupdown       	S:on
> networking     	S:on
> inetd          				2:on	3:on	4:on	5:on
> portmap        	S:on
> syslog         				2:on	3:on	4:on	5:on
>

Yup, got it. I used initdconfig to add all of the services I wanted.
Then, I turned them on.

Works perfectly!

Many thanks again for all of your help -- and such an excellent product.

				-James


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
