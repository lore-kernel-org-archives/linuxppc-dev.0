Date: Thu, 24 Feb 2000 09:47:59 +0100 (MET)
From: Gabriel Paubert <paubert@iram.es>
To: Patrick Lerda <Lerda@microprocess.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Linux 2.3.47 .... PCI boards... Linux beta in general
In-Reply-To: <B0CAE42C9EE0D311AAAD00500422FC6302CD7B@iis000.microdata.fr>
Message-ID: <Pine.HPX.4.10.10002240943550.16514-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 23 Feb 2000, Patrick Lerda wrote:

>
> I've tried linux 2.3.47 on my PowerPC 740 board, the core seems working but
> a lot of drivers don't work properly.
>
> serial:	linux see my two ISA 16C550 intel compatible, but console go only to
> framebuffer

Do you have CONFIG_SERIAL_CONSOLE, I have problems with 2.3.45 on my
750 machines, but the serial console is working. You'll have to add
console=ttyS0 however since a VT console will be used by default otherwise
if compiled in (actually I have headless machines).

>
> PCI boards:
> 	Adaptec SCSI, start and crash when HD is found. OOPS here
> 	IDE	idem

NCR53C8xx seems to work.

>
> 	Ethernet NE2000 board found, fail later.
> 	Tulip, found fail later.

On some machies DE4X5 works better...

> otherwise:
> 	USB core seems to work

I don't have any USB.

> If you have success with theses kernels.

I'm going to try to upgrade...

	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
