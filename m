Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18390.9230.26317.123518@cargo.ozlabs.ibm.com>
Date: Tue, 11 Mar 2008 17:17:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 4/8] pseries: phyp dump: register dump area.
In-Reply-To: <47C751F1.5040505@austin.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com> <47C751F1.5040505@austin.ibm.com>
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com, mahuja@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Manish Ahuja writes:

> +#define NUM_DUMP_SECTIONS 3
> +#define DUMP_HEADER_VERSION 0x1
> +#define DUMP_REQUEST_FLAG 0x1
> +#define DUMP_SOURCE_CPU 0x0001
> +#define DUMP_SOURCE_HPTE 0x0002
> +#define DUMP_SOURCE_RMO  0x0011

I think it would be clearer if you use a tab to line up the values,
like this:

#define NUM_DUMP_SECTIONS	3
#define DUMP_HEADER_VERSION	0x1
#define DUMP_REQUEST_FLAG	0x1
#define DUMP_SOURCE_CPU		0x0001
#define DUMP_SOURCE_HPTE	0x0002
#define DUMP_SOURCE_RMO		0x0011

Paul.
