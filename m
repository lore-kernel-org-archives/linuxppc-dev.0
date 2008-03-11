Return-Path: <dale@farnsworth.org>
To: Linuxppc-dev@ozlabs.org
In-Reply-To: <18390.9137.626123.104628@cargo.ozlabs.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com> <47C75189.4070801@austin.ibm.com>
Message-Id: <E1JZ7aD-0002FG-Qy@xyzzy.farnsworth.org>
From: Dale Farnsworth <dale@farnsworth.org>
Date: Tue, 11 Mar 2008 09:44:09 -0700
Subject: Re: [PATCH 3/8] pseries: phyp dump: use sysfs to release reserved mem
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul wrote:
> Manish Ahuja writes:
> > +		dump_header = of_get_property(rtas, "ibm,kernel-dump",
> > +								&header_len);
> 
> This is a somewhat weird-looking way of coping with too-long lines.

Yes, but not too surprising, since it precisely follows the recommendation
(and the example) in Chapter 2 of Documentation/CodingStyle.  :)

-Dale
