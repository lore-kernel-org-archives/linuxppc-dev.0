Return-Path: <miltonm@bga.com>
In-Reply-To: <20060810185514.GA12848@mag.az.mvista.com>
References: <11155228690643c98691.1714636915.miltonm@bga.com>
	<20060810185514.GA12848@mag.az.mvista.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <a90773d560ff8b4efc68c2de3c3bf7d5@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [RFC] consolidated libdt proposal
Date: Thu, 10 Aug 2006 23:55:32 -0500
To: "Mark A. Greer" <mgreer@mvista.com>
Cc: hollisb@us.ibm.com, pantelis@embeddedalley.com,
	xen-ppc-devel@lists.xensource.com, linuxppc-dev@ozlabs.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Aug 10, 2006, at 1:55 PM, Mark A. Greer wrote:
> On Thu, Aug 10, 2006 at 11:51:30AM -0500, Milton Miller wrote:
>> On Tue Aug  8 2006 01:04:08 PM CDT, Mark A. Greer wrote:
>>> If we're going to allow cmdline editing in the bootwrapper, we would
>>> need to extend the size of a property.
...
>> We already have replace the command line merged (it's why my patches
>> don't apply).
> That's different.
...

Yes, but it still requires changing the size or inserting a
property, which is the real requirement we were discussing.

Yes, editing at command line would require an input function.

milton
