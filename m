Message-ID: <XFMail.991209110250.gdt@linuxppc.org>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.10.9912090723100.23296-100000@shell.unixbox.com>
Date: Thu, 09 Dec 1999 11:02:50 -0700 (MST)
From: Gary Thomas <gdt@linuxppc.org>
To: Ani Joshi <ajoshi@shell.unixbox.com>
Subject: RE: Mozilla preM12 ppc rpms...
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On 09-Dec-99 Ani Joshi wrote:
> 
> 
> I have placed a preM12 snapshot at
> 
> ftp://devel.linuxppc.org/users/ajoshi/{RPMS,SRPMS}
> 
> This build includes Franz Sirl's XPTCall port.  
> Please let me know how it well it fares for everyone as we have not 
> tested it much.
> 

Where can I find all of the required pieces?

[root@icarus gary]# rpm -ivUh /tmp/mozilla-5.0-M11.ppc.rpm 
error: failed dependencies:
        glibc >= 2.1.3-0h is needed by mozilla-5.0-M11
        libIDL-0.6.so.0 is needed by mozilla-5.0-M11
        libgtkmozilla.so.0 is needed by mozilla-5.0-M11
        libstdc++-libc6.1-2.so.3 is needed by mozilla-5.0-M11
        libc.so.6(GLIBC_2.1.3) is needed by mozilla-5.0-M11

------------------------------------------------------------------------
Gary Thomas                              |
email: gdt@linuxppc.org                  | "Fine wine is a necessity of
   ... opinions expressed here are mine  |        life for me"
       and no one else would claim them! |
                                         |      Thomas Jefferson
------------------------------------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
