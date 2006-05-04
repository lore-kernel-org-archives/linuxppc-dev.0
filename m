Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CC21A67A3D
	for <linuxppc-dev@ozlabs.org>; Fri,  5 May 2006 08:11:06 +1000 (EST)
In-Reply-To: <6B4D81B3-ECB5-4492-B3EE-16EAAEBF1405@kernel.crashing.org>
References: <Pine.LNX.4.44.0605041622180.3700-100000@gate.crashing.org>
	<6B4D81B3-ECB5-4492-B3EE-16EAAEBF1405@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <55C365AA-2BA4-406C-8518-616F8182FAE5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Please pull from 'for_paulus' branch of powerpc
Date: Thu, 4 May 2006 17:10:56 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 4, 2006, at 5:09 PM, Segher Boessenkool wrote:

> Hi Kumar,
>
>> +static int ppc_panic_event(struct notifier_block *this,
>> +                             unsigned long event, void *ptr)
>> +{
>> +	ppc_md.panic((char *)ptr);  /* May not return */
>> +	return NOTIFY_DONE;
>> +}
>
> Lose the redundant pointer cast while you're there please?
>
>>  void __init setup_arch(char **cmdline_p)
>>  {
>>  	extern void do_init_bootmem(void);
>> +	extern void setup_panic(void);
>
> Can those two go into a header file please?

any suggestions on which header?
