Message-ID: <XFMail.991009093426.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.9910091006520.6043-100000@localhost.localdomain>
Date: Sat, 09 Oct 1999 09:34:26 -0600 (MDT)
From: Gary Thomas <gdt@linuxppc.org>
To: Claude Robitaille <crobitaille@videotron.ca>
Subject: RE: Calling convention
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 09-Oct-99 Claude Robitaille wrote:
> 
> Hi,
> 
> 
> I think Linux/Gcc is using SVR4 calling convention for PPC but
> where can I find an easy to read description?
> 

Linux/PPC (GCC) definitely uses the SYS Vr4 ABI.  You can find the
description at:
  ftp://ftp.linuxppc.org/users/gdt/sysv_abi.7.25.gz

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
