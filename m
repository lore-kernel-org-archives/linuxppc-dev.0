Return-Path: <jwboyer@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.230])
	by ozlabs.org (Postfix) with ESMTP id BD34CDDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2009 01:33:07 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id l9so1877970rvb.9
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2009 06:33:06 -0800 (PST)
Sender: Josh Boyer <jwboyer@gmail.com>
Date: Tue, 17 Feb 2009 09:32:51 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: dayu@datangmobile.cn
Subject: Re: [PATCH] fix the interrupt loss problem on powerpc IPIC (2.6.23)
Message-ID: <20090217143251.GA1803@yoda.jdub.homelinux.org>
References: <D728AD1FA2543948B89DE29C5BF4CD0716AC2DDE@bjmail1.bj.datangmobile.com>
	<76C7F485-EF75-4B83-B673-564E6243C7C6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <76C7F485-EF75-4B83-B673-564E6243C7C6@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 17, 2009 at 08:12:33AM -0600, Kumar Gala wrote:
>
> On Feb 17, 2009, at 6:44 AM, <dayu@datangmobile.cn> <dayu@datangmobile.cn 
> > wrote:
>
>> From: Da Yu <dayu@datangmobile.cn>
>> Date: Tue, 17 Feb 2009 19:58:20 +0800
>> Subject: [PATCH] fix the interrupt loss problem on powerpc IPIC  
>> (2.6.23)
>>
>> Signed-off-by: Da Yu <dayu@datangmobile.cn>
>> ---
>
> Please provide a bit more description as to why this fixes the issue.

Including whether it still applies to mainline, since your topic seems
to indicate it's for 2.6.23.  That is pretty old by now.

josh
