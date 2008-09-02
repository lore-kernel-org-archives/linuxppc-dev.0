Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>
Subject: Re: gdb woes 
In-reply-to: <02d301c90c34$e7c1f2d0$ad289e86@LPSC0173W> 
References: <02d301c90c34$e7c1f2d0$ad289e86@LPSC0173W>
Date: Tue, 02 Sep 2008 11:03:29 +1000
Message-ID: <28414.1220317409@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <02d301c90c34$e7c1f2d0$ad289e86@LPSC0173W> you wrote:
> Hello all,
> I have some trouble when trying to use gdb to debug a custom app.
> That app crashes for no reason but always on the same spots (probably 
> hardware related, it runs on homebrew ppc-based card).
> I've used gdb in the past, but always as part of 'bigger' IDEs.
> 
> So I run "gdb myapp" locally on the card and I get the prompt. Then I "run" 
> it and I get dumped back to bash, but a "ps" shows that the app is still 
> running... Anybody has a clue to what I can do about this ? Is there 
> something wrong with my gdb (it's compiled as part of buildroot, like the 
> rest of the OS) ?

If you can reduce your problem to a simple test case that others can
reproduce, it will be easier for others to look at your issue.  

If you think it's a problem with GDB, you might want to send this
message to an appropriate GDB list here:
  http://sourceware.org/gdb/mailing-lists/

Mikey
