Return-Path: <a.othieno@bluewin.ch>
Date: Thu, 18 Aug 2005 10:58:48 -0400
To: Sanjeevi Gopal <sanjeevig@gmail.com>
Message-ID: <20050818145848.GC2726@mars>
References: <37c1be9b050818044671528ae9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <37c1be9b050818044671528ae9@mail.gmail.com>
From: a.othieno@bluewin.ch (Arthur Othieno)
Cc: Linuxppc-embedded@ozlabs.org
Subject: Re: How to implementing CLI using bison and FLEX
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Aug 18, 2005 at 05:16:19PM +0530, Sanjeevi Gopal wrote:
> HI,
> 
> 
>         I am currenly working on mpc850 processor.I wanted to
> implement a Command Line interface. I like implement it using bison
> and flex tool. If anyone is familar or already implemented plz help me
 
See the Lex and YACC HOWTO[1] on tldp.org for a gentle introduction,
and the flex[2] and bison[3] manuals on gnu.org for the gory details:

[1] http://tldp.org/HOWTO/Lex-YACC-HOWTO.html
[2] http://www.gnu.org/software/flex/manual/
[3] http://www.gnu.org/software/bison/manual/
