Return-Path: <benh@kernel.crashing.org>
Subject: Re: PTE entries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Siva Prasad <sprasad@bivio.net>
In-Reply-To: <D83235F0F3C86D4D889D8B9A0DA8C6D762C6C3@corpexc01.corp.networkrobots.com>
References: <D83235F0F3C86D4D889D8B9A0DA8C6D762C6C3@corpexc01.corp.networkrobots.com>
Content-Type: text/plain
Date: Tue, 24 Apr 2007 11:05:00 +1000
Message-Id: <1177376700.14873.40.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-04-19 at 21:34 -0700, Siva Prasad wrote:
> Hi,
> 
>  
> 
> Where exactly the PTE are setup for any given new user program?
> 
>  
> 
> In other words, if you are trying to execute a user level program,
> kernel needs to load it and setup PTEs for that program. Where does
> kernel do it?

They are faulted in.

See do_page_fault

Ben.
