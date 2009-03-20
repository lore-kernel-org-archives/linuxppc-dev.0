Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5701EDDDA0
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Mar 2009 07:12:32 +1100 (EST)
Message-ID: <49C3F8AB.7070507@grandegger.com>
Date: Fri, 20 Mar 2009 21:12:27 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Wolfgang Grandegger <wg@grandegger.com>, linuxppc-dev@ozlabs.org
Subject: Re: powerpc/85xx: Add support for the "socrates" board (MPC8544)
References: <49C26434.30302@grandegger.com>
	<20090320041022.GB30527@yookeroo.seuss>
In-Reply-To: <20090320041022.GB30527@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Thu, Mar 19, 2009 at 04:26:44PM +0100, Wolfgang Grandegger wrote:
[snip]
> [snip[
>> +		display@2,0 {
>> +			compatible = "fujitsu,lime";
> 
> This compat string looks slightly worryingly non-specific.

The node is for the Lime graphic controller from Fujitsu. What does
worry you?

Wolfgang.
