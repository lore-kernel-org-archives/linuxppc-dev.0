Return-Path: <gerald.vanbaren@smiths-aerospace.com>
Received: from AGRXSUSMAILB.smiths.aero (host241-chi.smiths-group.com
	[65.216.75.241]) by ozlabs.org (Postfix) with ESMTP id 54C76DDDCA
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Feb 2007 00:02:22 +1100 (EST)
Message-ID: <45DAF156.40604@smiths-aerospace.com>
Date: Tue, 20 Feb 2007 08:02:14 -0500
From: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>,  linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 0/2] libfdt: problems with real life blobs
References: <45D9E5D9.6060704@smiths-aerospace.com>
	<20070219234631.GD17818@localhost.localdomain>
In-Reply-To: <20070219234631.GD17818@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Mon, Feb 19, 2007 at 01:00:57PM -0500, Jerry Van Baren wrote:
>> Hi David,
>>
>> I've been trying to use your libfdt in u-boot and my first step, get a 
>> value from the blob, failed terminally.  After poking about a bit, it 
>> appears that your libfdt and Jon Loeliger's dtc (-V 16) disagree with 
>> respect to the format of the blob - libfdt won't traverse the path.
> 
> That's certainly bad.
> 
>> I've created two patches:
> 
> Ug.  Damn.  Trouble is, for IBM paranoid procedural reasons, I'm not
> really in a position to accept patches for libfdt from outside at
> present.  I'm already working on fixing that, but there being a
> ponderous bureaucracy involved, it's going to take a little while.

That's OK, just call it "the illustration of advice formerly known as a 
patch."  I just hope I didn't poison the well. ;-)

Seriously, I don't claim copyright on the changes, that would be 
inappropriate their trivial nature.  I do understand IBM's paranoia, 
however.  }:-(

gvb
