Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18067.29586.481904.580320@cargo.ozlabs.ibm.com>
Date: Tue, 10 Jul 2007 21:54:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Wade Farnsworth <wfarnsworth@mvista.com>
Subject: Re: [PATCH v3] Create add_rtc() function to enable the RTC CMOS driver
In-Reply-To: <1182358772.5674.383.camel@rhino>
References: <1182298510.5674.358.camel@rhino> <1182358772.5674.383.camel@rhino>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Wade Farnsworth writes:

> In order to use the RTC CMOS driver, each architecture must register a
> platform device for the RTC.
> 
> This creates a function to register the platform device based on the RTC
> device node and verifies that the RTC port against the hard-coded value
> in asm/mc146818rtc.h.

The patch appears to be line-wrapped.  Please re-send.

Paul.
