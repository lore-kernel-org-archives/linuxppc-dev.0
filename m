Date: Fri, 22 Oct 1999 10:21:40 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: phandel@cise.ufl.edu
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Questions about rsync "linux-devel" -
In-Reply-To: <Pine.LNX.4.10.9910221220520.18946-100000@PetesBox.localdomain>
Message-ID: <Pine.LNX.4.10.9910221017160.20412-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




	If you want a recent 2.3 kernel, try a 2.3.22 linus kernel (from
ftp.us.kernel.org), i patched it up and it should build fone on ppc with
my patch located at 

	ftp://devel.linuxppc.org/users/ajoshi/2.3.22-ppc.patch

be sure to config for Pmac *only*, not for pmac/chrp/prep cause i recall
some prep issues still which i haven't bothered to include in the patch.
but if you setup for pmac, you should be fine.


ani


On Fri, 22 Oct 1999 phandel@cise.ufl.edu wrote:

> 
> I'm interested in spending some time with the linux kernel, and I've got
> some questions about samba.anu.edu.au::linux-pmac-devel - 
> 


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
