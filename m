Return-Path: <jschopp@austin.ibm.com>
Message-ID: <48728942.6050007@austin.ibm.com>
Date: Mon, 07 Jul 2008 16:23:14 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Dave Kleikamp <shaggy@linux.vnet.ibm.com>
Subject: Re: [patch 0/6] Strong Access Ordering page attributes for POWER7
References: <20080618223254.966080905@linux.vnet.ibm.com>	
	<1215128392.7960.7.camel@pasglop>
	<1215439540.16098.15.camel@norville.austin.ibm.com>
In-Reply-To: <1215439540.16098.15.camel@norville.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@linux-foundation.org>, Linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@au1.ibm.com>, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


>> We haven't defined a user-visible feature bit (and besides, we're really
>> getting short on these...). This is becoming a bit of concern btw (the
>> running out of bits). Maybe we should start defining an AT_HWCAP2 for
>> powerpc and get libc updated to pick it up ?
>>     
>
> Joel,
> Any thoughts?
Is it a required or optional feature of the 2.06 architecture spec?  If it's required you could just use that.  It doesn't solve the problem more generically if other archs decide to implement it though.
