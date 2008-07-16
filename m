Return-Path: <timur@freescale.com>
Message-ID: <487E0D43.9080602@freescale.com>
Date: Wed, 16 Jul 2008 10:01:23 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [RFC] I2C: fsl-i2c: make device probing configurable via FDT
References: <487DD1BD.8040701@grandegger.com>	<9e4733910807160547q28f49865o11ec878d98987329@mail.gmail.com>	<487DF304.7090205@grandegger.com>	<9e4733910807160724s136ef980weeeea2488ad7adf2@mail.gmail.com>	<20080716143042.GF24045@secretlab.ca>
	<9e4733910807160742t7037c098k67dcbbadbac992fc@mail.gmail.com>
In-Reply-To: <9e4733910807160742t7037c098k67dcbbadbac992fc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jean Delvare <khali@linux-fr.org>, Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> Probing an i2c bus does not necessarily come to a good conclusion. The
> probes for some chips can alter the states in others. People have
> accidentally changed voltage settings and fried CPU chips. The process
> is not well defined.

I agree.  We should not be implementing any feature that encourages I2C bus
probing.

-- 
Timur Tabi
Linux kernel developer at Freescale
