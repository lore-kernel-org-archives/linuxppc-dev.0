Date: Mon, 21 Jun 1999 22:48:12 -0400 (EDT)
From: Hollis R Blanchard <hollis+@andrew.cmu.edu>
To: Troy Benjegerdes <hozer@drgw.net>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: dl-load.c (ld.so) bug??
In-Reply-To: <Pine.LNX.4.04.9906212045480.27642-100000@narn.local.drgw.net>
Message-ID: <Pine.LNX.3.96L.990621222014.5237C-100000@unix47.andrew.cmu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> No. Electric Fence is designed to catch programming errors, such as
> attempting to access memory which was not 'malloc'ed. I have traced this
> down extensively a couple of months ago, and found that it does indeed
> appear to overrun what it malloced.

I have two even simpler test cases for you:

int main(void){
    char *ptr=NULL;
    free(ptr);
}

and

int main(void){
    char *ptr = (char *)malloc(100);
}        

Both of these work fine (or at least *appear* to work fine) without Electric
Fence.

> In normal operation, if I am correct, the ld.so code is just silently
> overwriting some other data. 

If this were the case, wouldn't you expect ridiculous levels of instability?

-Hollis


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
