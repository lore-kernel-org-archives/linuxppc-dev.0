Return-Path: <Marc.Dietrich@ap.physik.uni-giessen.de>
Received: from merkurneu.hrz.uni-giessen.de (merkurneu.hrz.uni-giessen.de
	[134.176.2.3]) by ozlabs.org (Postfix) with ESMTP id 45E5667B63
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 03:48:57 +1000 (EST)
Date: Thu, 17 Aug 2006 19:16:42 +0200
From: Marc Dietrich <Marc.Dietrich@ap.physik.uni-giessen.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Who cares about PReP?
Message-Id: <20060817191642.a9cb43bc.marc.dietrich@ap.physik.uni-giessen.de>
In-Reply-To: <17634.65529.252720.646039@cargo.ozlabs.ibm.com>
References: <17622.58559.879330.496619@cargo.ozlabs.ibm.com>
	<20060816101527.GA21865@iram.es>
	<17634.65529.252720.646039@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Thu__17_Aug_2006_19_16_42_+0200_FjEPg2R0.iIajo44"
Cc: Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Multipart=_Thu__17_Aug_2006_19_16_42_+0200_FjEPg2R0.iIajo44
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 16 Aug 2006 21:22:33 +1000
Paul Mackerras <paulus@samba.org> wrote:
> If you (and anyone else who is interested) could send me the contents
> of /proc/residual, /proc/iomem, /proc/ioports and /proc/interrupts
> from your systems (one of each different type) that could be helpful.

ok

# cat /proc/cpuinfo
processor       : 0
cpu             : 604
clock           : 133MHz
revision        : 3.4 (pvr 0004 0304)
bogomips        : 266.24
machine         : PReP IBM 7248, PowerSeries 830/850 (Carolina)
upgrade cpu     : not present
scsi fuse       : ok
simms           : 0:32MiB 1:32MiB 2:8MiB 3:8MiB 
l2 cache        : 512KiB, sync

# cat /proc/iomem
c0000000-feffffff : PCI host bridge
  c0000000-c07fffff : 0000:00:0e.0
  c0800000-c080001f : 0000:00:0c.0
  c0800100-c08001ff : 0000:00:10.0
    c0800100-c08001ff : sym53c8xx
  c0804000-c0807fff : 0000:00:12.0
    c0804000-c0807fff : matroxfb MMIO
  c1000000-c17fffff : 0000:00:12.0
    c1000000-c17fffff : matroxfb FB
  c1800000-c1ffffff : 0000:00:12.0

# cat /proc/ioports
  00000000-0000001f : dma1
  00000020-00000021 : 8259 (master)
  00000040-0000005f : timer
  00000060-0000006f : i8042
  00000074-0000007b : nvram
  00000080-0000008f : dma page reg
  000000a0-000000a1 : 8259 (slave)
  000000c0-000000df : dma2
  000002f8-000002ff : serial
  000003c0-000003df : vga+
  000003f8-000003ff : serial
  000004d0-000004d1 : 8259 edge control
  00001000-00001007 : 0000:00:0b.0
  00001020-0000103f : 0000:00:0c.0
    00001020-0000103f : pcnet32_probe_pci
  00001400-000014ff : 0000:00:10.0
    00001400-000014ff : sym53c8xx

# cat /proc/interrupts
           CPU0       
  1:       2645   i8259     Edge      i8042
  2:          0   i8259     Edge      82c59 secondary cascade
 12:      23379   i8259     Edge      i8042
 15:       6379   i8259     Level     sym53c8xx, eth0
BAD:          0

residual is attached

thanks !
	
marvin

--Multipart=_Thu__17_Aug_2006_19_16_42_+0200_FjEPg2R0.iIajo44
Content-Type: application/octet-stream;
 name="7248_residual.gz"
Content-Disposition: attachment;
 filename="7248_residual.gz"
Content-Transfer-Encoding: base64

H4sIAA+i5EQCA+2aTWhcVRTHz3n3zrybSdqZRWttjfpMuohTF6Ek7fg9KchgIZhaCvUL0phqFMEs
apz4gS86SHFhpWiVLmpw4UJBaxEREVss3alkIcVlqYLBjcFFrRAYz/14H/OaN0JFEHp+w5n78j/n
nnfevXfuzeIBPN0HCHD/rvFgYmJvMP7s9MFngp3bR2rB0H23Qgz5tTg6un3H2K7RIICronwOoKIv
ivqeWfw/FvaJv+ofu9hF+gpcfJCydE/tlE5PXZsQ/eWRhZlWexCkkHANU3BGrHfjFjWebXHVjmmB
2t3CjusETdJJHVcHpUP1lwxBKXdNGRV1EctmiqH3stPJ+qgRK/a67FqdvqxjfJu+3AY7T1pvh27O
lLkH4MvAMP8NMrW/RIv5WmOT/r1tHYdSmwAYivaHeHt244IU40cxSnqRv4esSrbNxfTGMSresm8j
u5PsLh0zttQLcYyIY+4mewDMZmPyqDgmKWgP2RTZ4zYPJHmS42Ga7ATZ+zbGS2IwjtFnzEWyn929
CnFMMb7XL+SiscHr9fiMLZVEFFOUUR7cTNsm1eQ9qNcSxcT3KuqQ/WZb3UsbIMWJLe5em2zMTF3G
9YgbyEbJdtiafZdnqo5eNM5iJ9kc2fM2RqKNueWsj3FMk+xtKuUpXQ/dq2z1wRDdDkvyIbIXyV6y
eYruzKzWMa5H0p4r3yE7lorxMjHvkn1KdtLGFNDmoXqiYwXkZ2Tf0/nwayrG64wp0KFRpD/8m2wM
JvPlRffybya7newOGyOiuTjekyxTWl8+rR9/wsaUo5ijPfFS9Wmu/INkT9j56nHdD5wzy3DWxDwJ
UKKZKz3kxvA6N4ZnTZpJ/VV6mOwRskd5C2UYhmEYhmEYhmEYhmEYhmEYhmEYhmEY5v/Ac7h1XITN
ZrOBG9QGhdjAftVPbWsdePp1DYSAPp4wIYpA1H1WjpAwABQ+C7OAntbgiAk6BIdIaOAczAGiDpPQ
QJ1Fq4uwaNoluSRtN1xobYQeEQCstNundVHRqx8mnREqDQwhBAwaeAbOmLYkS1InqsiKxOEGLsgF
ib0NPC/PS8RqRdrclGMQAtXAqqoqHV9TNfOYk2rStFNqyj0TvtYqgNqzxdxY10RFw+U+W4vqGLDI
u/J7+950xbHezuiPgaBMob5eda1hv33lxbyuMolQdn/BbOo6TK7xpL62H++t5LpVhOK+xVX0WjdC
wb2ncyYz1aYg6zdvs4Sdbltqyr/Q4YDwnsQv0h3DdEsjl8wp9gK852Kj93BoQhUoDGlCVWhaqEBF
TwzNYwVlA+e9eU9PzHxpvqTbw+KwQKmfcOPQK9DWFcDaT4hRhdDtCQehZF9X8kCApOAi+FRTD5Sg
F/pgHaynAdXLNqBiRwojBSw2sO7VPVxXxZmqN6N9dYgecMU9YDG9BEj/U3QMH1TlTMsVrhOEceDX
LjAa1GZ128xwF3+s+516uk9TdK7aWL+iT/Dv+ng5fYqdfWrN/q3j/dA/tgSy2RLgox//MFfog9Re
EpcE/XDrL8SeWfpoz5yY055QewYq8U0uZwpuDndxDg+oxOdlfUm/oItvuYuvJrr061LLlTkTX62L
70IX31DGV6Nhy396HrYuw4a0B9ShDnpjOgAHwJ4UFXP6eeSbhEnQm9Q0TLvDDiprqIMQquhsiN5s
zJ4Zn2d2ykj/0ukyo592el9G/06snf+HnPw/5ug/Ob2Q0Zd3ZfL/0/8Yu9euZ/nVHP31HP2NHP3N
HP1ojn4sRz+eo5/I0T/I0T/M0T/K0T/J0U/l6F/k6F/l6N/k6BfX1n9bQ/cCc566JRJYfTNIJO0C
aj38Nu1rGvjfa4ZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhGIZhmKvmb3CmTncM
agAA

--Multipart=_Thu__17_Aug_2006_19_16_42_+0200_FjEPg2R0.iIajo44--
