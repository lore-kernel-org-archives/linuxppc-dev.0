Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 6E491DDEE3
	for <linuxppc-dev@ozlabs.org>; Sat,  5 Jul 2008 16:53:08 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so1537146wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 04 Jul 2008 23:53:07 -0700 (PDT)
Date: Sat, 5 Jul 2008 00:53:04 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Segher Boessenkool <segher@kernel.crashing.org>,
	Matt Sealey <matt@genesi-usa.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: New fsl device bindings file
Message-ID: <20080705065304.GA20762@secretlab.ca>
References: <40B88BFD-1FEB-4E36-9917-54C7380FF801@kernel.crashing.org>
	<20080703185312.GA6043@polina.dev.rtsoft.ru>
	<486E26C0.9060604@genesi-usa.com>
	<e88aa775e8f6dcc85f1e4b9c3ca28fdd@kernel.crashing.org>
	<20080705012624.GA3032@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20080705012624.GA3032@yookeroo.seuss>
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 05, 2008 at 11:26:24AM +1000, David Gibson wrote:
> On Sat, Jul 05, 2008 at 01:12:31AM +0200, Segher Boessenkool wrote:
> >>> 	/* deprecated; */
> >>> 	device_type = "i2c";
> >>
> >> How about "deprecated but kept for compatibility with true Open  
> >> Firmware
> >> implementations"?
> >
> > Well, except a flat tree isn't compatible with OF at all here.
> > A "device_type" promises a certain interface; a flat tree doesn't
> > even have the "open" method.  From the OF base spec:
> >
> > 	“device_type” S
> >
> > 	Standard property name to specify the implemented interface.
> >
> > 	prop-encoded-array: Text string encoded with encode-string.
> >
> > 	Specifies the “device type” of this package, thus implying a
> > 	specific set of package class methods implemented by this
> > 	package.
> >
> >> Seriously, you can't have a binding for "OF" and then cut out that  
> >> part of the
> >> standard at a whim.
> >
> > Nothing is cut out.  There never was a device binding for device_type
> > i2c; creating one would be a considerable effort, and since flat tree
> > users wouldn't use it anyway, you can't be seriously suggesting they
> > should do this.
> >
> >> It should be there (at least for those parts which are
> >> governed by a client interface API, like display, serial etc.
> >
> > Huh?  Nothing in the client interface mentions display or serial
> > as far as I know.
> >
> >> but cutting it off takes away all it's meaning,
> >
> > So what?  There _is_ no "real" device interface, when a flat tree is
> > used.
> >
> >> plus Linux implementations STILL keep searching
> >> that property along with "compatible",
> >
> > That's a bug.
> 
> Thank you Segher, you saved me the trouble of saying exactly all that.

Ditto.

g.
