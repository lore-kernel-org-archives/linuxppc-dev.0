Date: Fri, 19 Jan 2001 00:05:25 -0600
From: Troy Benjegerdes <hozer@drgw.net>
To: eraineri@axiom-tx.com
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: kernel 2.4 SMP on quad PPC
Message-ID: <20010119000525.B17347@altus.drgw.net>
References: <3A6748FB.42C51F82@axiom-tx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3A6748FB.42C51F82@axiom-tx.com>; from eraineri@axiom-tx.com on Thu, Jan 18, 2001 at 01:50:19PM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Jan 18, 2001 at 01:50:19PM -0600, eraineri@axiom-tx.com wrote:
>
> Hello,
> I have searched the arhives and didn't seem to find what I'm looking
> for.  I currently am in the process of porting linux to a custom PPC
> Quad board.  I downloaded a 2.5 kernel  from FSMlabs in December and
> have had success getting 2 processors to come up.  However, I could not
> get 3 or 4.  I am considering going to the 2.4 latest kernel on the
> FSMlabs bitkeeper site.  I'm wondering if the version of the 2.5 kernel
> I downloaded works with more then duals and also if I should instead
> download the 2.4 kernel and us it?  I know that eventually I am going to
> have to go to 2.4 but I would like to show some success before
> abandoning the 2.5 version I've worked so hard to get.  If I in the
> incorrect mailing list I apologize.  I'm fairly new to the Linux kernel
> development world!
>
> Thanks for all the help
> Eddy

linuxppc_2_5 has been updated to the 2.4.0 kernel version. You should just be
able to do a pull and merge in all the new stuff. (make another clone or
otherwise back up your tree just in case this gets messed up)

--------------------------------------------------------------------------
Troy Benjegerdes                'da hozer'                hozer@drgw.net


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
