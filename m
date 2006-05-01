Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17494.34882.682062.350203@cargo.ozlabs.ibm.com>
Date: Tue, 2 May 2006 08:14:26 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: DTC/dts modifications
In-Reply-To: <695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
	<1146512012.24239.28.camel@cashmere.sps.mot.com>
	<695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> Because of props like:
> 
>        #cpus = <1>;
>        #address-cells = <1>;
>        #size-cells = <0>;
> 
> If these used some other symbol instead of '#' cpp will be happy and  
> we can use it to create macros for us.

I think it will get really really confused if the dts says "$cpus = 1"
but that turns into a "#cpus" property.

There are other macro processors besides cpp, you know - why not look
at m4, for instance?

Paul.
