Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18394.2775.159266.704402@cargo.ozlabs.ibm.com>
Date: Fri, 14 Mar 2008 16:19:19 +1100
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
In-Reply-To: <47D8AD9C.2030106@austin.ibm.com>
References: <47B90F55.2080606@austin.ibm.com>
	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>
	<47C74A66.1060105@austin.ibm.com> <47C750CE.7050202@austin.ibm.com>
	<1205197341.8656.5.camel@concordia.ozlabs.ibm.com>
	<3ae3aa420803121052g6ded9c94xd23823a4e81f4bbf@mail.gmail.com>
	<47D8AD9C.2030106@austin.ibm.com>
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

> If Mike and Paul are okay, then I will leave this bit as is and fix all 
> other issues and comments.

Well, part of the problem is the semantic dissonance caused by having
a static variable called "global".  Please change the name
"phyp_dump_global" to "phyp_dump_vars" or something similar - that
will only affect two lines of code and will reduce the ugliness a bit.

Paul.
