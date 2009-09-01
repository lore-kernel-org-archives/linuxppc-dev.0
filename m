Return-Path: <ben@somanetworks.com>
Received: from zimbra.somanetworks.com (gw-yyz.somanetworks.com
	[216.126.67.39])
	by bilbo.ozlabs.org (Postfix) with ESMTP id 567EFB7B88
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  1 Sep 2009 13:57:25 +1000 (EST)
Message-ID: <4A9C9BA3.6020105@somanetworks.com>
Date: Mon, 31 Aug 2009 23:57:23 -0400
From: Benjamin Gamsa <ben@somanetworks.com>
MIME-Version: 1.0
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: time jumps forward/backwards
References: <4A9C465D.4010801@somanetworks.com>	<19100.24755.889091.412993@cargo.ozlabs.ibm.com>	<4A9C6446.2000202@somanetworks.com>	<4A9C664D.6010504@somanetworks.com>	<4A9C84D0.8040200@somanetworks.com>
	<20090831223111.7b2dc95d@lappy.seanm.ca>
In-Reply-To: <20090831223111.7b2dc95d@lappy.seanm.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sean MacLennan wrote:
> On Mon, 31 Aug 2009 22:20:00 -0400
> Benjamin Gamsa <ben@somanetworks.com> wrote:
> 
>> For what it's worth, the problem occurs even when ntp is not even
>> started.
> 
> This is grasping, but could it have anything to do with the jiffies
> wrapping near startup?
> 

I don't know how to test it, but I don't think so, since there are 
multiple of these glitches over an extended period of time.

	ben
