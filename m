Return-Path: <gerald.vanbaren@comcast.net>
Received: from rwcrmhc11.comcast.net (rwcrmhc11.comcast.net [216.148.227.151])
	by ozlabs.org (Postfix) with ESMTP id 09BC4DDE31
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Mar 2007 11:35:49 +1100 (EST)
Message-ID: <45FC8963.9080603@comcast.net>
Date: Sat, 17 Mar 2007 20:35:47 -0400
From: Jerry Van Baren <gerald.vanbaren@comcast.net>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] DTC: Improve options handling
References: <45FC1F69.9080204@comcast.net>
	<20070317231337.GA11017@localhost.localdomain>
In-Reply-To: <20070317231337.GA11017@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Sat, Mar 17, 2007 at 01:03:37PM -0400, Jerry Van Baren wrote:
>> Hi David, Jon,
>>
>> Here is another fairly trivial patch for dtc.  It adds -h to get the 
>> usage message.  It adds -q (-qq/-qqq) to suppress warnings/errors.
>> It removes the -R option which is advertised but does nothing
>> useful.
> 
> NAK.  -R does do something that I believe is useful.

Hi David,

-R sets a local variable reservenum to the specified value.  Nobody uses 
reservenum, hence my conclusion that it does nothing useful.

Best regards,
gvb
