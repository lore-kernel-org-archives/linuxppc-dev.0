Return-Path: <knight@princeton.edu>
Received: from skuld.princeton.edu (skuld.Princeton.EDU [128.112.173.239])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 727292C02A4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 08:16:54 +1000 (EST)
Message-ID: <51AFB8D4.6010603@princeton.edu>
Date: Wed, 05 Jun 2013 18:16:52 -0400
From: Robert Knight <knight@princeton.edu>
MIME-Version: 1.0
To: wenxiong@linux.vnet.ibm.com
Subject: Re: IBM OpenPower 720 ipr driver woes
References: <51A61B82.5050508@princeton.edu>
 <20130605180145.Horde.HbMAPpir309Rr7VJiFkHOuA@imap.linux.ibm.com>
In-Reply-To: <20130605180145.Horde.HbMAPpir309Rr7VJiFkHOuA@imap.linux.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 6/5/2013 6:01 PM, wenxiong@linux.vnet.ibm.com wrote:
>
> Quoting Robert Knight <knight@princeton.edu>:
>
>> Sometime after kernel 3.3.4, Fedora 17 running on an IBM OpenPower 
>> 720 stopped being able to read the SCSI disks with an error 
>> concerning a return code -1.  In the updates since, it has not 
>> resumed working.
>>
> Can you tell me which kernel you saw this issue(I assumed that 3.3.4 
> works fine).
kernel 3.8.11-100, for example
> Also can you check your system firmware for me?
I don't know how to do that.  lsvpd?
