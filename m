Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18436.18955.450131.623072@cargo.ozlabs.ibm.com>
Date: Tue, 15 Apr 2008 16:24:11 +1000
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
In-Reply-To: <47FFF4E8.9010705@austin.ibm.com>
References: <47FAB221.7050406@austin.ibm.com> <47FFF4E8.9010705@austin.ibm.com>
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Manish Ahuja writes:

> B. It computers 5% of total ram and rounds it down to multiples of 256MB.
> C. Compares the rounded down value and returns larger of 256MB or the new
>    computed value.

So if we have 10GB of memory or more we'll use reserve more than
256MB.  What is the advantage of reserving more than 256MB of memory?

Paul.
