Date: Wed, 31 Jan 2001 18:49:01 +0200 (EET)
From: Kostas Gewrgiou <gewrgiou@imbc.gr>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Gareth Hughes <gareth@valinux.com>, <linuxppc-dev@lists.linuxppc.org>,
        <linux-fbdev@vuser.vu.union.edu>
Subject: Re: r128 DRI driver now fully functional on PPC
In-Reply-To: <19341226052133.13170@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.30.0101311825220.9967-100000@idd-01.imbc.gr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 31 Jan 2001, Benjamin Herrenschmidt wrote:

> I'll do some tests with the broken 16 bits mode to see if I get 3D
> working properly. I'll then see if I can figure out what cause the chip
> to lockup without UseFBDev.

After a quick look i noticed that R128EnterVTFBDev/R128LeaveVTFBDev have to
enable/disable DRI just as R128EnterVT/R128LeaveVT. So dont try to switch to
console until its fixed while you use UseFBDev and DRI.

Kostas


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
