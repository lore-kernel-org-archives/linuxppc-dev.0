From: Paul Mackerras <paulus@linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14837.27948.882957.344247@argo.linuxcare.com.au>
Date: Tue, 24 Oct 2000 22:06:20 +1100 (EST)
To: toa@pop.agri.ch
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: 2.2.18-pre17 candidate
In-Reply-To: <39F53B02.B3E5CAF4@pop.agri.ch>
References: <14837.11341.207379.903189@argo.linuxcare.com.au>
	<39F53B02.B3E5CAF4@pop.agri.ch>
Reply-To: paulus@linuxcare.com.au
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Andreas Tobler writes:

> My menuconfig breaks with the msg 'MCmenu36: command not found report it
> to ......'. On the quick it's not very helpful I know.
> I also wondered why 'Mac device drivers' is the last entry in the
> menuconfig, no sound, nor Kernel hacking.

Oops, missed an endmenu in arch/ppc/config.in.  Try rsyncing again
now.

Paul.

--
Paul Mackerras, Senior Open Source Researcher, Linuxcare, Inc.
+61 2 6262 8990 tel, +61 2 6262 8991 fax
paulus@linuxcare.com.au, http://www.linuxcare.com.au/
Linuxcare.  Support for the revolution.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
