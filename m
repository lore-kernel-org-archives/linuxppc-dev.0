Date: Fri, 6 Dec 2002 02:41:10 +0100
From: Peter Vandenabeele <peter.vandenabeele@mind.be>
To: Alexander.J@lntinfotech.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Target CPU selection for Real time Embedded Linux
Message-ID: <20021206024109.S1931@mind.be>
Reply-To: Peter Vandenabeele <peter.vandenabeele@mind.be>
References: <OFB8D7A27E.4DFEB42B-ON65256C86.003DE12F@lntinfotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <OFB8D7A27E.4DFEB42B-ON65256C86.003DE12F@lntinfotech.com>; from Alexander.J@lntinfotech.com on Thu, Dec 05, 2002 at 04:48:32PM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Dec 05, 2002 at 04:48:32PM +0530, Alexander.J@lntinfotech.com wrote:
>
> Hi all,
>
> We would like to build a Router software engine using Real Time Embedded
> linux.

The alternatives that immediately come to Mind are:

- Xilinx Virtex II Pro with Linux (Linux port posted 2 months ago and on ftp.mind.be)
- Intel IXP425 with Linux (Linux port expected Jan 2003)

I believe both those chips where targeted specifically to build
high-end, modern one-chip routing solutions. They have high speed
connections on them.

What is the bandwidth and number of interfaces you are targeting ?

> In this process, we need to freeze the target CPU. Could anyone help me in
> this regard?

In the telecom sector PowerPC is the standard (the optimized power consumption
of the ARM family is less relevant in switches; and PowerPC is high-performant).

XScale (ARM derived) is also a new performant platform that is available at
high frequencies in certain chips (80200 e.g.). Typical operation frequencies
of PowerPC405 and XScale in both chips are 300 MHz I believe.

Please note that the use of the FPGA created some very spectacular possibities,
such as the idea to build-in a wirespeed firewall in the FPGA logic, where you
could reprogram the rules through a reconfiguration of the FPGA filters (this
is not a SW firewall, but it is still reprogrammable).

Peter

> Thanks
> Alex
>

--
.--------------------------------------------------------.
|       Mind: Embedded Linux and eCos Development.       |
| Mind is looking for Embedded Linux and eCos Developers |
|--------------------------------------------------------|
| Peter Vandenabeele, CEO          email:  peter@mind.be |
| Mind (http://mind.be)            tel:  +32-16-30.96.66 |
| Vaartkom 11                      fax:  +32-16-30.96.44 |
| B-3000 Leuven, Belgium           gsm: +32-478-27.40.69 |
'--------------------------------------------------------'

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
