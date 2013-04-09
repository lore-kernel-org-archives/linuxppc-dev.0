Return-Path: <chris.friesen@genband.com>
Received: from exprod7og119.obsmtp.com (exprod7og119.obsmtp.com [64.18.2.16])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0E2522C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Apr 2013 00:31:39 +1000 (EST)
Message-ID: <51642620.4050201@genband.com>
Date: Tue, 09 Apr 2013 08:30:56 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc userspace address space layout information
References: <515E58E6.9030802@genband.com>
 <20130407055844.GB17787@truffula.fritz.box>
In-Reply-To: <20130407055844.GB17787@truffula.fritz.box>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/06/2013 11:58 PM, David Gibson wrote:
> On Thu, Apr 04, 2013 at 10:53:58PM -0600, Chris Friesen wrote:

>> Third, what's the most reliable way to ensure a block of addresses around
>> 0xf6000000 don't get used for shared libraries?  (We want to preserve
>> those addresses for emulating hardware in a virtual machine.)  We have
>> this working on an older system but after upgrading to new software the
>> libraries now extend further down the address space.
>
> The only reliable method I can think of would be to use a custom
> linker script to give your binary an extra program header specifying
> that virtual region to map.

Thanks for your help.  We had started working on the custom linker 
script while waiting to see if anyone would respond, so it's good to get 
some validation that we picked the right solution.

Chris
