Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id C17C967D14
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Nov 2006 01:27:50 +1100 (EST)
Message-ID: <4551E95F.5080407@ru.mvista.com>
Date: Wed, 08 Nov 2006 17:27:43 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: [PATCH] adding ROM chips to device tree: respin
References: <20061107141923.16b2d2f1.vwool@ru.mvista.com>		<4550A5E6.50409@ru.mvista.com>
	<1162934221.2680.2.camel@barja>		<4550F9B8.40901@ru.mvista.com>
	<1162935862.2680.7.camel@barja>		<45510013.8010509@ru.mvista.com>
	<1162937920.2680.10.camel@barja> <45510B5E.9000104@ru.mvista.com>
In-Reply-To: <45510B5E.9000104@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, I wrote:
>     We could also try using "device_type" or "name" properties to name the 
> of_device -- this name doesn't matter much anyway...

    Now, after looking thru some code, I think using the "name" prop is indeed 
the way to go...

WBR, Sergei
