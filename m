Message-ID: <388D02DB.2357F917@huawei.com.cn>
Date: Tue, 25 Jan 2000 09:56:43 +0800
From: dony <dony.he@huawei.com.cn>
MIME-Version: 1.0
To: bsapp@lanl.gov, linuxppc-embed <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: cross-compile gdb questions...
References: <388BC86C.E182A092@huawei.com.cn> <388C72C7.58A02642@nua.lampf.lanl.gov>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, Ben:
      I have tried this before but failed. When I run "make" , it shows
many warnings and "undefined reference to ..." errors.
     So how do you solve it?
     Thanks very much.
     dony

Ben Sapp wrote:

> Hello dony,
>
> To get powerpc-linux-gdb running go to ftp://prep.ai.mit.edu/gnu/gdb
> directory and download the latest version.(gdb-4.18.tar.gz)   Unpack it
> with the following commands:
>
> gunzip -c gdb-4.18.tar.gz | tar -xvf -
>
> This will make a directory called gdb-4.18  cd into that directory.
> Then, run the following command:
>
> ./configure --target=powerpc-linux
>
> You can add any options to configure as is appropriate.   To find out
> all the options read the install file and run
>
> ./configure --help
>
> Once you have done this simply run
>
> make ; make install
>
> Then you will have powerpc-linux-gdb installed on your intel box.
>
> --
> Ben Sapp                         Los Alamos National Laboratory
> email: <mailto:bsapp@lanl.gov>   Phone: (505)667-3277
> Fax:   (505)665-7920             URL:   http://www.neutrino.lanl.gov/
> --


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
