Date: Mon, 16 Jul 2001 14:22:09 +1000
From: Steven Hanley <sjh@svana.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel ftp ?
Message-ID: <20010716142208.A430@wibble.net>
Reply-To: Steven Hanley <sjh@wibble.net>
References: <3B51A448.F63C9AE9@denise.shiny.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3B51A448.F63C9AE9@denise.shiny.it>; from pochini@denise.shiny.it on Sun, Jul 15, 2001 at 04:10:16PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 15, 2001 at 04:10:16PM +0200, Giuliano Pochini wrote:
>
> Is there an ftp server with the latest ppc kernels or I have to use bk ?

all the latet kerneles for ppc tend to also be available with rsync, install
rsync and grab the kernels with something like

benh rsync -avz --delete-after penguinppc.org::linux-2.4-benh .

paulus rsync -avz --delete-after penguinppc.org::linux-pmac-{stable,devel,etc} .

bk rsync -avz --delete-after bitkeeper.fsmlabs.com::linuxppc_2_4 linuxppc_2_4

no idea if the bitkeeper one is stil there but hey. I use the benh kernels
generally as they work best with my pismo and work fine with my 7220/200
anyway.

        See You
            Steve

--
sjh@wibble.net http://wibble.net/~sjh/
Look Up In The Sky
   Is it a bird?  No
      Is it a plane?  No
         Is it a small blue banana?
YES

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
