Date: Wed, 12 Mar 2003 23:52:51 -0800
From: Ira Weiny <iweiny@acm.org>
To: Manuj Dhingra <manuj_dhingra@ae.gatech.edu>
Cc: linuxppc <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Upgrade Blues 2.4.20 Ben H kernel
Message-Id: <20030312235251.304f407d.iweiny@acm.org>
In-Reply-To: <20030310164855.GC11462@haar.ae.gatech.edu>
References: <20030310164855.GC11462@haar.ae.gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 10 Mar 2003 11:48:55 -0500
Manuj Dhingra <manuj_dhingra@ae.gatech.edu> wrote:

>
> Well I am, but I have not seen this one before. With Ben's m3mirror and
> corresponding ioctls, crt:1 did turn on the external display, it was just
> not stable.
> Could you please boot with external monitor plugged in at power on and
> pass video=aty128fb:crt:1,lcd:1 as additional boot parameters?
>
>

One more thing I forgot to mention:

m3mirror crt:0  (and 1) will turn it off and on as expected.

Thanks guys,
Ira


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
