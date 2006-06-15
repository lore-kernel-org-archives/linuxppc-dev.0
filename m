Return-Path: <cyeoh@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17553.18542.579764.191739@localhost.localdomain>
Date: Thu, 15 Jun 2006 21:45:50 +1000
From: "Christopher Yeoh" <cyeoh@samba.org>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH 0/3] powerpc: Instrument Hypervisor Calls: add sysfs files
In-Reply-To: <20060614142223.GD26750@localdomain>
References: <20060614034756.GA6759@monkey.ibm.com>
	<20060614035420.GD6759@monkey.ibm.com>
	<20060614142223.GD26750@localdomain>
Cc: linuxppc-dev@ozlabs.org, Bryan Rosenburg <rosnbrg@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At 2006/6/14 09:22-0500  Nathan Lynch writes:
> > +
> > +static SYSDEV_ATTR(hcall_stats, 0666, show_hcall_stats, NULL);
> 
> Mode should be 0444 or 0400, no need to have write permissions.
> 

The original version zeroed all of the counters if you wrote anything
to the file. This was kind of handy when doing test runs.

Chris
-- 
cyeoh@au.ibm.com
IBM OzLabs Linux Development Group
Canberra, Australia
